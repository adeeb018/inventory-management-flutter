import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../data/repositories/part_report_repository_impl.dart';
import '../../domain/usecases/get_part_report.dart';
import '../bloc/part_report_bloc.dart';
import '../bloc/part_report_event.dart';
import '../bloc/part_report_state.dart';

class PartReportPage extends StatelessWidget {
  final int projectId;

  const PartReportPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    // Get token from AuthBloc
    final authBloc = context.read<AuthBloc>();
    final token = (authBloc.state is AuthAuthenticated)
        ? (authBloc.state as AuthAuthenticated).token
        : authBloc.token;

    // Initialize repository and use-case
    final repository = PartReportRepositoryImpl(token: token!);
    final getPartReport = GetPartReport(repository);

    return BlocProvider(
      create: (_) => PartReportBloc(getPartReport: getPartReport)
        ..add(FetchPartReport(projectId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Parts for Project #$projectId'),
        ),
        body: BlocBuilder<PartReportBloc, PartReportState>(
          builder: (context, state) {
            if (state is PartReportLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PartReportError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${state.message}'),
                ),
              );
            }
            if (state is PartReportLoaded) {
              if (state.parts.isEmpty) {
                return const Center(child: Text('No parts found'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.parts.length,
                itemBuilder: (context, index) {
                  final part = state.parts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text('${part.partNumber} — ${part.partDescription}'),
                      subtitle: Text(
                        'Mfr: ${part.manufacturer}  |  Type: ${part.partType}\n'
                            'MPN: ${part.manufacturerPartNumber}',
                      ),
                      isThreeLine: true,
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Qty', style: TextStyle(fontSize: 12)),
                          Text('${part.quantityUsed}', style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
